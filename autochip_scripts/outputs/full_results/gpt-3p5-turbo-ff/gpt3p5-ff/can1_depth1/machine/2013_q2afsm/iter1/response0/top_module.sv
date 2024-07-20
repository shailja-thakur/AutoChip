module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output [2:0] g
);

    reg [1:0] state;
    reg [1:0] next;

    always @(posedge clk) begin
        if (!resetn)
            state <= 2'b00;  // set state to A
        else
            state <= next;   // set state to the value of next register
    end

    always @* begin
        case (state)
            2'b00: begin
                if (r[2])       // if r[2] is high, next state is C
                    next = 2'b10;
                else if (r[1])  // if r[1] is high, next state is B
                    next = 2'b01;
                else if (r[0])  // if r[0] is high, next state is D
                    next = 2'b11;
                else            // if none of the bits are high, next state is A
                    next = 2'b00;
            end

            2'b01: begin
                if (r[1])       // if r[1] is high, next state is B
                    next = 2'b01;
                else            // if r[1] is low, next state is A
                    next = 2'b00;
            end

            2'b10: begin
                if (r[2])       // if r[2] is high, next state is C
                    next = 2'b10;
                else            // if r[2] is low, next state is A
                    next = 2'b00;
            end

            2'b11: begin
                if (r[0])       // if r[0] is high, next state is D
                    next = 2'b11;
                else            // if r[0] is low, next state is A
                    next = 2'b00;
            end
        endcase
    end

    assign g[0] = (state == 2'b01) ? 1'b1 : 1'b0; // g[0] is high if current state is B
    assign g[1] = (state == 2'b10) ? 1'b1 : 1'b0; // g[1] is high if current state is C
    assign g[2] = (state == 2'b11) ? 1'b1 : 1'b0; // g[2] is high if current state is D

endmodule
