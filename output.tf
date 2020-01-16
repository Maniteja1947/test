output "postgresql_id" {
    value       = "${azurerm_postgresql_server.postgresql.id}"
    description = "The storage account Resource ID."
}

output "postgresql_fqdn" {
    value       = "${azurerm_postgresql_server.postgresql.fqdn}"
    description = "fully qualified domain name"
}

output "postgesql_dns_record" {
    value = "${element(data.dns_a_record_set.postgresqlserver.addrs, 0)}"
}
