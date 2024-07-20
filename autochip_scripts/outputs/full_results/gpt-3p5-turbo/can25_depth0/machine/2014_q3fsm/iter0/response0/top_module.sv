module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    reg [3:0] state, next_state;

    localparam A = 4'b0000;
    localparam B = 4'b0001;
    localparam C = 4'b0010;
    localparam S10 = 4'b0011;
    localparam S11 = 4'b0100;
    localparam S20 = 4'b0101;
    localparam S21 = 4'b0110;
    localparam S22 = 4'b0111;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    always @(state or s or w) begin
        case (state)
            A: begin
                if (s)
                    next_state = B;
            end
            B, C: begin
                if (w)
                    next_state = S11;
                else
                    next_state = S10;
            end
            S10: begin
                if (w)
                    next_state = S21;
                else
                    next_state = S20;
            end
            S11: begin
                if (w)
                    next_state = S22;
                else
                    next_state = S21;
            end
            S20: begin
                next_state = B;
            end
            S21: begin
                if (w)
                    next_state = C;
                else
                    next_state = B;
            end
            S22: begin
                if (w)
                    next_state = B;
                else
                    next_state = C;
            end
        endcase
    end

    always @(posedge clk) begin
        if (state == S10)
            z <= 1'b1;
        else
            z <= 1'b0;
    end

endmodule
