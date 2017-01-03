#TODO
@{
    AllNodes = @(
        @{
            NodeName            = 'localhost';
            Role                = 'template';
            Data                = 
            @{
                Path            = 'c:\file.txt';
                Content         = 'this is some text';
                Destination  = 'c:\archive.zip';
            };
        }
    )
}
