$NumberLetterArray = @{ 'cc41ec2f-7aae-47d9-a910-70b02b71d535' = '192.168.1.72'; 'b' = 2; 'c' = 3}

foreach ($e in $NumberLetterArray.GetEnumerator()) {
  echo $e.Value$e.Name
}

