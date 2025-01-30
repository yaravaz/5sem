using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpotTrigger : MonoBehaviour
{
    public Light light2;
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnTriggerStay(Collider c2)
    {
        if(c2.name == "player") light2.transform.Rotate(0, 5, 0);
    }
}
