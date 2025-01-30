using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TriggerScript : MonoBehaviour
{
    public Light light1;
    void Start()
    {
        
    }

    void Update()
    {
        
    }

    private void OnTriggerEnter(Collider c1)
    {
        if (c1.name == "player") light1.enabled = true;
    }
    private void OnTriggerExit(Collider c1)
    {
        if (c1.name == "player") light1.enabled = false;
    }
}
