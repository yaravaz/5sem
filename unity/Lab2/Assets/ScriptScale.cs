using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScriptScale : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        float newScaleX = transform.localScale.x + 15 * Time.deltaTime;
        float newScaleY = transform.localScale.y + 15 * Time.deltaTime;

        transform.localScale = new Vector3(newScaleX, newScaleY, transform.localScale.z);
    }
}
