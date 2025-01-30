using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Move_Key : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        float goX = 0f;
        float goY = 0f;
        float goZ = 0f;

        if (Input.GetKey(KeyCode.W)) goY = 1f;  
        if (Input.GetKey(KeyCode.A)) goX = -1f; 
        if (Input.GetKey(KeyCode.S)) goY = -1f; 
        if (Input.GetKey(KeyCode.D)) goX = 1f;  
        if (Input.GetKey(KeyCode.Q)) goZ = -1f; 
        if (Input.GetKey(KeyCode.E)) goZ = 1f;  

        Vector3 move = new Vector3(goX, goY, goZ);

        transform.position += move * 3 * Time.deltaTime;
    }
}
