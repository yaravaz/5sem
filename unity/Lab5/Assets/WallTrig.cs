using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WallT : MonoBehaviour
{
    public GameObject wall;

    private void OnTriggerStay(Collider col)
    {
        if (col.name == "corpus")
            wall.transform.Rotate(0, 1.5f, 0);
    }
}
