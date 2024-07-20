module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    reg [5:0] consecutive_ones;
    reg [2:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            disc <= 0;
            flag <= 0;
            err <= 0;
            consecutive_ones <= 6'b000000;
            state <= 3'b000;
        end else begin
            case (state)
                3'b000: begin // State_0: Waiting for first consecutive 0 in flag pattern
                    if (in) begin
                        consecutive_ones <= 6'b000001;
                        state <= 3'b001;
                    end else begin
                        consecutive_ones <= 6'b000000;
                        state <= 3'b000;
                    end
                end
                3'b001: begin // State_1: Counting consecutive 1s after first 0 in flag pattern
                    if (in) begin
                        consecutive_ones <= consecutive_ones + 1;
                        if (consecutive_ones == 6'b111110) begin
                            disc <= 1;
                            flag <= 0;
                            err <= 0;
                            state <= 3'b010;
                        end else if (consecutive_ones == 6'b111111) begin
                            disc <= 0;
                            flag <= 1;
                            err <= 0;
                            state <= 3'b011;
                        end else begin
                            state <= 3'b001;
                        end
                    end else begin
                        consecutive_ones <= 6'b000000;
                        state <= 3'b000;
                    end
                end
                3'b010: begin // State_2: Detected 7 or more consecutive 1s (error)
                    if (in) begin
                        consecutive_ones <= consecutive_ones + 1;
                        err <= 1;
                        state <= 3'b010;
                    end else begin
                        consecutive_ones <= 6'b000000;
                        state <= 3'b000;
                    end
                end
                3'b011: begin // State_3: Detected flag pattern
                    if (in) begin
                        consecutive_ones <= consecutive_ones + 1;
                        flag <= 1;
                        err <= 0;
                        state <= 3'b011;
                    end else begin
                        consecutive_ones <= 6'b000000;
                        state <= 3'b100;
                    end
                end
                3'b100: begin // State_4: Waiting for first consecutive 0 after flag pattern
                    if (in) begin
                        consecutive_ones <= 6'b000001;
                        state <= 3'b001;
                    end else begin
                        consecutive_ones <= 6'b000000;
                        state <= 3'b100;
                    end
                end
                default: state <= 3'b000;
            endcase
        end
    end

endmodule
