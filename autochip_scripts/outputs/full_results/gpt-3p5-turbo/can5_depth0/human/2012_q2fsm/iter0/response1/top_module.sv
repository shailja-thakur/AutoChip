module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    reg [2:0] state, next_state;

    always @(posedge clk, posedge reset)
    begin
        if (reset)
            state <= 3'b000;
        else
            state <= next_state;
    end

    always @(state, w)
    begin
        case (state)
            3'b000: begin
                if (w)
                    next_state = 3'b010;
                else
                    next_state = 3'b000;
            end

            3'b001: begin
                if (w)
                    next_state = 3'b100;
                else
                    next_state = 3'b011;
            end

            3'b010: begin
                if (w)
                    next_state = 3'b101;
                else
                    next_state = 3'b011;
            end

            3'b011: begin
                if (w)
                    next_state = 3'b110;
                else
                    next_state = 3'b000;
            end

            3'b100: begin
                if (w)
                    next_state = 3'b100;
                else
                    next_state = 3'b011;
            end

            3'b101: begin
                if (w)
                    next_state = 3'b101;
                else
                    next_state = 3'b011;
            end

            3'b110: begin
                if (w)
                    next_state = 3'b010;
                else
                    next_state = 3'b011;
            end
        endcase
    end

    always @(state)
    begin
        case(state)
            3'b000: z = 1'b0;
            3'b001: z = 1'b0;
            3'b010: z = 1'b0;
            3'b011: z = 1'b0;
            3'b100: z = 1'b0;
            3'b101: z = 1'b1;
            3'b110: z = 1'b0;
        endcase
    end

endmodule
