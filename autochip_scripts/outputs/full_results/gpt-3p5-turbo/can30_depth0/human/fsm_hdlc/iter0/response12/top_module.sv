module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    reg [2:0] state;
    reg [5:0] consecutive_ones;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b0;
            consecutive_ones <= 6'd0;
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end else begin
            case (state)
                3'b000: begin  // state 0
                    if (in) begin
                        state <= 3'b001;  // state 1
                        consecutive_ones <= 6'd1;
                    end else begin
                        state <= 3'b000;
                        consecutive_ones <= 6'd0;
                    end
                end

                3'b001: begin  // state 1
                    if (in) begin
                        state <= 3'b001;  // state 1
                        consecutive_ones <= consecutive_ones + 1;
                    end else begin
                        state <= 3'b010;  // state 2
                        consecutive_ones <= 6'd0;
                    end
                end

                3'b010: begin  // state 2
                    if (in) begin
                        state <= 3'b001;  // state 1
                        consecutive_ones <= 6'd1;
                    end else begin
                        state <= 3'b011;  // state 3
                        consecutive_ones <= 6'd0;
                    end
                end

                3'b011: begin  // state 3
                    if (in) begin
                        state <= 3'b001;  // state 1
                        consecutive_ones <= 6'd1;
                    end else begin
                        if (consecutive_ones == 6'd5) begin
                            state <= 3'b100;  // state 4
                            consecutive_ones <= 6'd0;
                            disc <= 1'b1;
                        end else begin
                            state <= 3'b000;  // state 0
                            consecutive_ones <= 6'd0;
                        end
                    end
                end

                3'b100: begin  // state 4
                    if (in) begin
                        state <= 3'b000;  // state 0
                        consecutive_ones <= 6'd1;
                    end else begin
                        state <= 3'b101;  // state 5
                        consecutive_ones <= 6'd0;
                        flag <= 1'b1;
                    end
                end

                3'b101: begin  // state 5
                    if (in) begin
                        if (consecutive_ones == 6'd1) begin
                            state <= 3'b110;  // state 6
                            consecutive_ones <= 6'd1;
                        end else begin
                            state <= 3'b000;  // state 0
                            consecutive_ones <= 6'd1;
                            err <= 1'b1;
                        end
                    end else begin
                        state <= 3'b101;
                        consecutive_ones <= 6'd0;
                    end
                end

                3'b110: begin  // state 6
                    if (in) begin
                        if (consecutive_ones < 6'd6) begin
                            state <= 3'b001;  // state 1
                            consecutive_ones <= 6'd1;
                            err <= 1'b1;
                        end else begin
                            state <= 3'b110;  // state 6
                            consecutive_ones <= consecutive_ones + 1;
                        end
                    end else begin
                        state <= 3'b110;
                        consecutive_ones <= consecutive_ones + 1;
                    end
                end
            endcase
        end
    end

endmodule
