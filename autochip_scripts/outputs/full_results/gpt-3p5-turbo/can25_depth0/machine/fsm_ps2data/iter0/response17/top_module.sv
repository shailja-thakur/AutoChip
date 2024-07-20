module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    parameter BYTE1 = 2'b00;
    parameter BYTE2 = 2'b01;
    parameter BYTE3 = 2'b10;
    parameter DONE = 2'b11;

    reg [1:0] state;
    reg [7:0] shift_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            shift_reg <= 0;
            done <= 0;
        end else begin
            case (state)
                BYTE1: begin
                    if (in[2]) begin
                        state <= BYTE2;
                    end else begin
                        state <= BYTE1;
                    end
                    shift_reg <= {shift_reg[23:8], in};
                end
                BYTE2: begin
                    state <= BYTE3;
                    shift_reg <= {shift_reg[23:8], in};
                end
                BYTE3: begin
                    state <= DONE;
                    shift_reg <= {shift_reg[23:8], in};
                end
                DONE: begin
                    if (in[2]) begin
                        state <= BYTE2;
                    end else begin
                        state <= BYTE1;
                    end
                    shift_reg <= 0;
                    done <= 1;
                end
                default: state <= BYTE1;
            endcase
        end
    end

    assign out_bytes = done ? shift_reg : 0;

endmodule
