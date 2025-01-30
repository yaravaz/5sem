using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestColorScript : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnTriggerEnter(Collider col)
    {
        Color col1 = new Color(1, 0, 0);
        if (col.gameObject.name == "player")
        {
            col.gameObject.GetComponent<Renderer>().material.color = col1;
        }
    }

    private void OnTriggerExit(Collider col)
    {
        Color col1 = new Color(0, 1, 0);
        if (col.gameObject.name == "player")
        {
            col.gameObject.GetComponent<Renderer>().material.color = col1;
        }
    }

}
