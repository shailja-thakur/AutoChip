module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2

    // New: Datapath to store incoming bytes.

    reg [23:0] out_bytes;
    reg [7:0] byte_1;
    reg [7:0] byte_2;
    reg [7:0] byte_3;
    reg state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    if (in[7] == 1) begin
                        state <= BYTE_1;
                        byte_1 <= in;
                    end
                end
                BYTE_1: begin
                    if (in[7] == 1) begin
                        state <= BYTE_2;
                        byte_2 <= in;
                    end else begin
                        state <= DONE;
                        out_bytes <= byte_1 << 16 | byte_2 << 8 | byte_3;
                     end
                end
                BYTE_2: begin
                    if (in[7] == 1) begin
                        state <= BYTE_3;
                        byte_3 <= in;
                    end else begin
                        state <= DONE;
                        out_bytes <= byte_1 << 16 | byte_2 << 8 | byte_3;
                     end
                end
                DONE: begin
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule