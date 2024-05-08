module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Insert your code below

    // Modify FSM and datapath from Fsm_serialdata

    // New: Add parity checking.

    // The FSM has the following states:
    //   * S0: Start bit detected.
    //   * S1: Data bits being received.
    //   * S2: Parity bit being received.
    //   * S3: Stop bit detected.
    //   * S4: Error.

    // The datapath consists of the following registers:
    //   * bit_counter: Counts the number of 1 bits received.
    //   * parity: The parity of the received data.
    //   * done: Asserted when a byte is correctly received and its parity check passes.

    // The FSM is controlled by the following signals:
    //   * clk: The clock signal.
    //   * reset: The reset signal.
    //   * in: The input bit stream.
    //   * done: Asserted when a byte is correctly received and its parity check passes.

    // The datapath is updated on the rising edge of the clock signal.

    // The FSM is implemented as follows:

    state machine
    S0:
        if (reset) begin
            bit_counter <= 0;
            parity <= 0;
        end else if (in) begin
            if (in == 1) begin
                bit_counter <= bit_counter + 1;
            end
        end else begin
            goto S3;
        end

    S1:
        if (in) begin
            if (in == 1) begin
                bit_counter <= bit_counter + 1;
            end
        end else begin
            goto S2;
        end

    S2:
        if (in) begin
            if (in == 1) begin
                bit_counter <= bit_counter + 1;
            end
        end else begin
            goto S3;
        end

    S3:
        if (in == 1) begin
            goto S4;
        end else begin
            goto S0;
        end

    S4:
        if (in == 1) begin
            goto S4;
        end else begin
            // Parity check: If the number of 1 bits in the received data is odd, then the parity bit should be 1. Otherwise, the parity bit should be 0.
            if (bit_counter % 2 == 1) begin
                if (parity == 1) begin
                    done <= 1;
                end else begin
                    done <= 0;
                end
            end else begin
                if (parity == 0) begin
                    done <= 1;
                end else begin
                    done <= 0;
                end
            end
        end

endmodule