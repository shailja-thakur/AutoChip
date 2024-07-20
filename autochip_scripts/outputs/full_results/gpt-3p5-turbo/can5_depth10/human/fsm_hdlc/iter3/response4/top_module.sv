module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);
  
    reg [2:0] state;
    reg [2:0] next_state;
    reg [5:0] consecutive_ones;
    reg in_prev;
  
    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;
            next_state <= 3'b000;
            consecutive_ones <= 6'b000000;
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            state <= next_state;
            case (state)
                3'b000: begin // State_0: Waiting for first consecutive 0 in flag pattern
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                    if (in & !in_prev) begin
                        consecutive_ones <= 6'b000001;
                        next_state <= 3'b001;
                    end else begin
                        consecutive_ones <= 6'b000000;
                        next_state <= 3'b000;
                    end
                end
                3'b001: begin // State_1: Counting consecutive 1s after first 0 in flag pattern
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                    if (in) begin
                        consecutive_ones <= consecutive_ones + 1;
                        if (consecutive_ones == 6'b111110) begin
                            next_state <= 3'b010;
                        end else if (consecutive_ones[5] == 1) begin
                            next_state <= 3'b011;
                        end else begin
                            next_state <= 3'b001;
                        end
                    end else begin
                        consecutive_ones <= 6'b000000;
                        next_state <= 3'b000;
                    end
                end
                3'b010: begin // State_2: Detected 7 or more consecutive 1s (error)
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                    if (in) begin
                        consecutive_ones <= consecutive_ones + 1;
                        next_state <= 3'b010;
                    end else begin
                        consecutive_ones <= 6'b000000;
                        next_state <= 3'b100;
                    end
                end
                3'b011: begin // State_3: Detected flag pattern
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                    if (in) begin
                        consecutive_ones <= consecutive_ones + 1;
                        next_state <= 3'b011;
                    end else begin
                        consecutive_ones <= 6'b000000;
                        next_state <= 3'b100;
                    end
                end
                3'b100: begin // State_4: Waiting for first consecutive 0 after flag pattern
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                    if (in & !in_prev) begin
                        consecutive_ones <= 6'b000001;
                        next_state <= 3'b001;
                    end else begin
                        consecutive_ones <= 6'b000000;
                        next_state <= 3'b100;
                    end
                end
            endcase
            in_prev <= in;
        end
    end

endmodule
