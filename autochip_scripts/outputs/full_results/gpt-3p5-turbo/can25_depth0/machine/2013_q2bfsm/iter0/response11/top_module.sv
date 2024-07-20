module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);

    reg [3:0] state, next_state;

    assign f = (state == 2'b01);
    assign g = (state == 2'b10) || (state == 2'b11) || (state == 2'b100);

    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= 2'b00;
        else
            state <= next_state;
    end

    always @(state, x, y) begin
        case (state)
            2'b00: begin
                if (x == 1)
                    next_state = 2'b10;
                else
                    next_state = 2'b00;
            end
            2'b01: begin
                if (x == 1)
                    next_state = 2'b01;
                else
                    next_state = 2'b100;
            end
            2'b10: begin
                if (x == 1)
                    next_state = 2'b11;
                else
                    next_state = 2'b00;
            end
            2'b11: begin
                if (x == 1)
                    next_state = 2'b11;
                else
                    next_state = 2'b1001;
            end
            2'b100: begin
                if (x == 1)
                    next_state = 2'b101;
                else
                    next_state = 2'b00;
            end
            2'b101: begin
                if (y == 1)
                    next_state = 2'b110;
                else
                    next_state = 2'b1000;
            end
            2'b110: begin
                if (y == 1)
                    next_state = 2'b110;
                else
                    next_state = 2'b101;
            end
            2'b1000: begin
                next_state = 2'b1000;
            end
            2'b1001: begin
                next_state = 2'b1001;
            end
        endcase
    end

endmodule
