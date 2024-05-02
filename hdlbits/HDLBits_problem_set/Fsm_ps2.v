// The PS/2 mouse protocol sends messages that are three bytes long. However, within a continuous byte stream, it's not obvious where messages start and end. The only indication is that the first byte of each three byte message always has bit[3]=1 (but bit[3] of the other two bytes may be 1 or 0 depending on data).

// We want a finite state machine that will search for message boundaries when given an input byte stream. The algorithm we'll use is to discard bytes until we see one with bit[3]=1. We then assume that this is byte 1 of a message, and signal the receipt of a message once all 3 bytes have been received (done).

// The FSM should signal done in the cycle immediately after the third byte of each message was successfully received.

// Although in[7:0] is a byte, the FSM only has one input: in[3].
// You need ~4 states. Three states likely wouldn't work because one of them needs to assert done, and done is asserted for only one cycle for each received message.

module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //

    // Insert your code below

    // State transition logic (combinational)

    // State flip-flops (sequential)
 
    // Output logic

endmodule