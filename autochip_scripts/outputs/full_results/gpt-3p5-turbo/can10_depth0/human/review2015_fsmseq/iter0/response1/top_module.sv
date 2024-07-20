module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);
    reg [3:0] state;
    reg [2:0] shift_reg;

    // State definitions
    parameter IDLE = 0;
    parameter S1 = 1;
    parameter S2 = 2;
    parameter S3 = 3;
    parameter FOUND = 4;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            start_shifting <= 0;
            state <= IDLE;
            shift_reg <= 3'b0;
        end else begin
            case(state)
                IDLE: begin
                    if (data) begin
                        shift_reg <= {shift_reg[1:0], data};
                        if (shift_reg == 3'b110) begin
                            state <= S1;
                        end
                    end
                end
                S1: begin
                    shift_reg <= {shift_reg[1:0], data};
                    if (shift_reg == 3'b1101) begin
                        state <= S2;
                    end else if (data) begin
                        state <= IDLE;
                    end
                end
                S2: begin
                    shift_reg <= {shift_reg[1:0], data};
                    if (shift_reg == 3'b1101) begin
                        state <= S3;
                    end else if (data) begin
                        state <= IDLE;
                    end
                end
                S3: begin
                    shift_reg <= {shift_reg[1:0], data};
                    if (shift_reg == 3'b1101) begin
                        state <= FOUND;
                    end else if (data) begin
                        state <= IDLE;
                    end
                end
                FOUND: begin
                    start_shifting <= 1;
                    if (reset) begin
                        state <= IDLE;
                        shift_reg <= 3'b0;
                    end
                end
            endcase
        end
    end
endmodule
