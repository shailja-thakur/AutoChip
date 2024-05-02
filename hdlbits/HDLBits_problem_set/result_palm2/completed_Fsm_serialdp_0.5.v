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

    reg [8:0] data;
    reg [1:0] state;
    reg [1:0] parity;
    reg done;

    // FSM states
    const [1:0] IDLE = 0;
    const [1:0] START = 1;
    const [1:0] DATA = 2;
    const [1:0] STOP = 3;

    // FSM transitions
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    if (in) begin
                        state <= START;
                        data <= 0;
                        parity <= 0;
                    end
                end
                START: begin
                    if (in) begin
                        data <= data + 1;
                        parity <= parity ^ in;
                        if (data == 8'h80) begin
                            state <= DATA;
                        end
                    end
                end
                DATA: begin
                    if (in) begin
                        data <= data + 1;
                        parity <= parity ^ in;
                        if (data == 8'h80) begin
                            state <= STOP;
                        end
                    end
                end
                STOP: begin
                    if (!in) begin
                        if (parity == 1) begin
                            done <= 1;
                        end
                        state <= IDLE;
                    end
                end
            endcase
        end
    end

    assign out_byte = data;

endmodule