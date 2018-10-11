<#-- @ftlvariable name="clusterId" type="java.lang.String" -->
<#-- @ftlvariable name="topic" type="org.kafkahq.models.Topic" -->

<#import "/includes/node.ftl" as nodeTemplate>
<#import "/includes/functions.ftl" as functions>

<table class="table table-bordered table-striped table-hover mb-0">
    <thead class="thead-dark">
        <tr>
            <th>Id</th>
            <th>Leader</th>
            <th>Replicas</th>
            <th>Offsets</th>
            <th>Size</th>
            <th class="row-action"></th>
        </tr>
    </thead>
    <tbody>
        <#list topic.getPartitions() as partition>
            <tr>
                <td>${partition.getId()}</td>
                <td><@nodeTemplate.badge partition.getLeader()/></td>
                <td>
                    <#list partition.getNodes() as replica>
                        <@nodeTemplate.badge replica/>
                    </#list>
                </td>
                <td>
                    ${partition.getFirstOffset()}
                    ⤑
                    ${partition.getLastOffset()}
                </td>
                <td>
                    ${partition.getLastOffset()-partition.getFirstOffset()}
                    -
                    ${functions.filesize(partition.getLogDir().getSize())}
                </td>
                <td class="row-action main-row-action">
                    <a href="/${clusterId}/topic/${topic.getName()}/partitions/${partition.getId()}" >
                <i class="fa fa-search"></i></a>
                </td>
            </tr>
        </#list>
    </tbody>
</table>