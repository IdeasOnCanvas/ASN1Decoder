//
//  Copyright © 2020 Alexander Heinrich & Filippo Maguolo.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import XCTest
@testable import ASN1Decoder

class ASN1SignatureTests: XCTestCase {
    
    func testGetSignatureFromPKCS7() throws {
        let signatures = try PKCS7(data: self.asn1TestFile).signatures
        XCTAssertEqual(signatures?.count, 1)
        let signature = signatures?.first
        XCTAssertNotNil(signature?.signatureData)
        XCTAssertEqual(signature?.disgestAlgorithmName, "sha1")
        XCTAssertEqual(signature?.signatureAlgorithmName, "rsaEncryption")
        XCTAssertEqual(signature?.digestAlgorithmOID, OID.sha1)
        XCTAssertEqual(signature?.signatureAlgorithmOID, OID.rsaEncryption)
    }
    
    private var asn1TestFile: Data {
        let b64String = "MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAaCAJIAEggqWPD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPCFET0NUWVBFIHBsaXN0IFBVQkxJQyAiLS8vQXBwbGUvL0RURCBQTElTVCAxLjAvL0VOIiAiaHR0cDovL3d3dy5hcHBsZS5jb20vRFREcy9Qcm9wZXJ0eUxpc3QtMS4wLmR0ZCI+CjxwbGlzdCB2ZXJzaW9uPSIxLjAiPgo8ZGljdD4KCTxrZXk+QXBwSUROYW1lPC9rZXk+Cgk8c3RyaW5nPnNlbGZzaWduZWQ6IGFueSBhcHA8L3N0cmluZz4KCTxrZXk+QXBwbGljYXRpb25JZGVudGlmaWVyUHJlZml4PC9rZXk+Cgk8YXJyYXk+CgkJPHN0cmluZz5TRUxGU0lHTkVEPC9zdHJpbmc+Cgk8L2FycmF5PgoJPGtleT5DcmVhdGlvbkRhdGU8L2tleT4KCTxkYXRlPjIwMjAtMDUtMjVUMDc6Mjk6MzJaPC9kYXRlPgoJPGtleT5QbGF0Zm9ybTwva2V5PgoJPGFycmF5PgoJCTxzdHJpbmc+aU9TPC9zdHJpbmc+Cgk8L2FycmF5PgoJPGtleT5EZXZlbG9wZXJDZXJ0aWZpY2F0ZXM8L2tleT4KCTxhcnJheT4KCQk8ZGF0YT5NSUlEU1RDQ0FqR2dBd0lCQWdJQkFUQU5CZ2txaGtpRzl3MEJBUXNGQURCS01TWXdKQVlEVlFRRERCMXBVR2h2Ym1VZ1JHVjJaV3h2Y0dWeU9pQlRaV3htSUZOcFoyNWxjakVUTUJFR0ExVUVDd3dLVTBWTVJsTkpSMDVGUkRFTE1Ba0dBMVVFQmhNQ1JFVXdIaGNOTWpBd05USTFNRGN5T1RNeVdoY05NekF3TlRJMU1EY3lPVE15V2pCS01TWXdKQVlEVlFRRERCMXBVR2h2Ym1VZ1JHVjJaV3h2Y0dWeU9pQlRaV3htSUZOcFoyNWxjakVUTUJFR0ExVUVDd3dLVTBWTVJsTkpSMDVGUkRFTE1Ba0dBMVVFQmhNQ1JFVXdnZ0VpTUEwR0NTcUdTSWIzRFFFQkFRVUFBNElCRHdBd2dnRUtBb0lCQVFDeXV0dXlaRHVQaVFrbGoxSWdHdk16Z0NrZGU5NXNHN1JZaFliLzd6YXRzcTFSNksxeWsxOXo4cEIwMUhTUzZSNXY3SjJoUThMenFwZEQ1YTF4WFo3RXI0a2s0MDdCbkN0dFdsVXZEVFNBajU3b2FBdW1KUzIvZ2RmODBmL2E1ZlhneWJraGhyZ05raFFYc0cxSkdZUStHOXIzZzhtMHpQbXg2QmxyM0ZuMWtpR0ZwWXJRRjB4cExNVElZRm5pZS9zV3VnMG41VUsyZlBmOEhWL3QzeHMxOWR2T3RXVzlBNGpxY212bXlXYWFpakszNGM5VmMzYkVuYWJ4bjd4ZExBT0xJWHVqSHdHUVMzMXhTT3F1aG5nZlNRVFgrRFR6b1NzUjhvdGpSaVgyTzZocjlQNzNZSDJhbXZmMFZuRVJkTFQ2MmFBNEQxZVZ5U1hXU3JHeE04UVJBZ01CQUFHak9qQTRNQTRHQTFVZER3RUIvd1FFQXdJSGdEQW1CZ05WSFNVQkFmOEVIREFhQmdnckJnRUZCUWNEQkFZSUt3WUJCUVVIQXdNR0JGVWRKUUF3RFFZSktvWklodmNOQVFFTEJRQURnZ0VCQURKL0FhYjdpVnArS1ZiWlpXR0VXVFd3cWFQbXArYUtEei8yeW0wTFBEUCtVMXdaNFUrK0dPNUJKRVY0ZU5BeEZNNlRaODJlV2gzL080ZGVadGFkMExpVTh5d0NWQXVBcWVBNEQ3VFRUVDBKTlRKUGtZSVliWVhDUHc5SE8xdVAvQVhNSXJJQllFRmpRemp2YnoyaGJMVlFlOWxrQjlTUnlBM1ZEbkpLYkdScVpHNlExajZFNHFSejdvcGZheUFib1dGZzRZTTJXdGpXZGgxTUU0MzJsTWlNZGpJNlAxYUdNaXdoc2h6MUlkMDNFcS9sTHRzWmh4L212SVVDN3ExamN2cVFVRmlQV2FsQmhoSE1ubWdiM0lzY0g3c1VxbzRCSDk1Tm1MUlJ0cEhmMTFHWEpGUVpEcURkQ1R0ei90V3ZWeFl0U1VJYWQ4cEIyVTQrSVRraldBQT08L2RhdGE+Cgk8L2FycmF5PgoJPGtleT5FbnRpdGxlbWVudHM8L2tleT4KCTxkaWN0PgoJCTxrZXk+a2V5Y2hhaW4tYWNjZXNzLWdyb3Vwczwva2V5PgoJCTxhcnJheT4KCQkJPHN0cmluZz5TRUxGU0lHTkVELio8L3N0cmluZz4KCQk8L2FycmF5PgoJCTxrZXk+Z2V0LXRhc2stYWxsb3c8L2tleT4KCQk8dHJ1ZS8+CgkJPGtleT5hcHBsaWNhdGlvbi1pZGVudGlmaWVyPC9rZXk+CgkJPHN0cmluZz5TRUxGU0lHTkVELio8L3N0cmluZz4KCQk8a2V5PmNvbS5hcHBsZS5kZXZlbG9wZXIuYXNzb2NpYXRlZC1kb21haW5zPC9rZXk+CgkJPHN0cmluZz4qPC9zdHJpbmc+CgkJPGtleT5jb20uYXBwbGUuZGV2ZWxvcGVyLnRlYW0taWRlbnRpZmllcjwva2V5PgoJCTxzdHJpbmc+U0VMRlNJR05FRDwvc3RyaW5nPgoJCTxrZXk+YXBzLWVudmlyb25tZW50PC9rZXk+CgkJPHN0cmluZz5wcm9kdWN0aW9uPC9zdHJpbmc+CgkJPGtleT5jb20uYXBwbGUuZGV2ZWxvcGVyLmV4cG9zdXJlLW5vdGlmaWNhdGlvbjwva2V5PgoJCTx0cnVlLz4KCQk8a2V5PmNvbS5hcHBsZS5kZXZlbG9wZXIuZXhwb3N1cmUtbm90aWZpY2F0aW9uLXRlc3Q8L2tleT4KCQk8dHJ1ZS8+Cgk8L2RpY3Q+Cgk8a2V5PkV4cGlyYXRpb25EYXRlPC9rZXk+Cgk8ZGF0ZT4yMDMwLTA1LTI1VDA3OjI5OjMyWjwvZGF0ZT4KCTxrZXk+TmFtZTwva2V5PgoJPHN0cmluZz5ETyBOT1QgVVNFOiBvbmx5IGZvciBkdW1teSBzaWduaW5nPC9zdHJpbmc+Cgk8a2V5PlByb3Zpc2lvbmVkRGV2aWNlczwva2V5PgoJPGFycmF5Lz4KCTxrZXk+VGVhbUlkZW50aWZpZXI8L2tleT4KCTxhcnJheT4KCQk8c3RyaW5nPlNFTEZTSUdORUQ8L3N0cmluZz4KCTwvYXJyYXk+Cgk8a2V5PlRlYW1OYW1lPC9rZXk+Cgk8c3RyaW5nPlNlbGZzaWduZXJzIHVuaXRlZDwvc3RyaW5nPgoJPGtleT5UaW1lVG9MaXZlPC9rZXk+Cgk8aW50ZWdlcj4zNjUyPC9pbnRlZ2VyPgoJPGtleT5VVUlEPC9rZXk+Cgk8c3RyaW5nPkI1QzI5MDZELUQ2RUUtNDc2RS1BRjE3LUQ5OUFFMTQ2NDRBQTwvc3Ry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"
        
        return Data(base64Encoded: b64String)!
    }
}
