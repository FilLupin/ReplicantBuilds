Builds of Replicant

The code was created on-the-fly so is unlikely to work without modifications.

_________________________________________

Replicant 6.0 build for the i9300

$ sudo chmod +x ./preInstCA.sh && sudo ./preInstCA.sh
$ chmod +x ./getDebian9.sh && ./getDebian9.sh
$ chmod +x mountunmount.sh
$ ./mountunmount.sh "before" && sleep 3 && sudo /usr/sbin/chroot --userspec=live:live squashfs-root /Sources/getSource-6.0.sh && sleep 3 && ./mountunmount.sh "after" && sleep 3
$ ./mountunmount.sh "before" && sleep 3 && sudo /usr/sbin/chroot --userspec=live:live squashfs-root /Sources/do-6.0.sh && sleep 3 && ./mountunmount.sh "after" && sleep 3
_________________________________________

To donate to me:

https://www.paypal.com/donate/?hosted_button_id=SZABYRV48SAXW

To donate to the replicant project:

https://crm.fsf.org/civicrm/contribute/transact?reset=1&id=19
