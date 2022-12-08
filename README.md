# NetworkManager - Connection Notifier

It's a script that sends a notification every time there's loss of connection (NetworkManager action: "down").
When connection is active (NetworkManager action: "down"), it sends a notification with info regarding connection speed, using speedtest.

## Installation

The script must be stored inside the NetworkManager dispatcher: 

```bash
cp connection_notifier.sh /etc/NetworkManager/dispatcher.d/90_connection_notifier
```

Here is the link to the Linux service this script relies on: [NetworkManager](https://developer-old.gnome.org/NetworkManager/stable/).

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[GPL-3.0](https://choosealicense.com/licenses/gpl-3.0/)