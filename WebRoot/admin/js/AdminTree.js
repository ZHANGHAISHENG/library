
var imgUp = "images/arrowUp.gif" ;
var imgDn = "images/arrowDn.gif" ;
function expandIt( num)
{   
	
	var bulletImg ;
	var parent=document.getElementById("Parent"+num);
	var child=document.getElementById("P"+num+"Child1");

	if ( parent)
		bulletImg =document.getElementById("p"+num+"i");
		    
	if ( child)
	{
		if ( child.style.display == "block")
		{
			child.style.display	= "none" ;
			bulletImg.src = imgUp ;
		}
		else
		{
			child.style.display	= "block" ;
			bulletImg.src = imgDn ;
		}
	}

}
	


