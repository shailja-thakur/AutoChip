module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    reg [2:0] state;
    reg [2:0] next_state;
    wire start_bit_detected;
    wire stop_bit_detected;

    // Internal signals
    wire start_bit = (state == 3'b000) ? 1'b0 : 1'b1;
    wire stop_bit = (state == 3'b010) ? 1'b1 : 1'b0;

    // Output signals
    assign start_bit_detected = start_bit;
    assign stop_bit_detected = stop_bit;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            out_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            case (state)
                3'b000: begin // Idle state
                    if (start_bit_detected) begin
                        state <= 3'b001;
                        out_byte <= 8'b0;
                    end else begin
                        state <= 3'b000;
                    end
                end
                3'b001: begin // Receiving data bits
                    state <= (state == 3'b111) ? 3'b010 : {state[1:0], 1'b0};
                    out_byte <= {out_byte[6:0], in};
                end
                3'b010: begin // Waiting for stop bit
                    if (stop_bit_detected) begin
                        state <= 3'b000;
                        done <= 1'b1;
                    end else begin
                        state <= 3'b010;
                    end
                end
                default: state <= 3'b000;
            endcase
        end
    end
endmodule
