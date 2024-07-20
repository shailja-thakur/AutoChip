module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

// Define the states
parameter A = 0;
parameter B = 1;
parameter C = 2;

// Define the state register
reg [1:0] state_reg;
reg [1:0] state_next;

// Define the count register
reg [1:0] count_reg;
reg [1:0] count_next;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state_reg <= A;
        count_reg <= 0;
    end
    else begin
        state_reg <= state_next;
        count_reg <= count_next;
    end
end

always @(state_reg, w) begin
    state_next = state_reg;
    count_next = count_reg;

    case (state_reg)
        A: begin
            if (s) begin
                state_next = B;
                count_next = 1;
            end
        end

        B: begin
            if (count_reg < 3) begin
                if (w) begin
                    count_next = count_reg + 1;
                end
            end
            else begin
                if (count_reg == 3) begin
                    if (w == 2'b11) begin
                        state_next = A;
                        count_next = 0;
                        z <= 1;
                    end
                    else begin
                        state_next = C;
                        count_next = 1;
                        z <= 0;
                    end
                end
            end
        end

        C: begin
            if (count_reg < 3) begin
                if (w) begin
                    count_next = count_reg + 1;
                end
            end
            else begin
                if (count_reg == 3) begin
                    if (w == 2'b11) begin
                        state_next = A;
                        count_next = 0;
                        z <= 1;
                    end
                    else begin
                        state_next = B;
                        count_next = 1;
                        z <= 0;
                    end
                end
            end
        end
    endcase
end
endmodule
