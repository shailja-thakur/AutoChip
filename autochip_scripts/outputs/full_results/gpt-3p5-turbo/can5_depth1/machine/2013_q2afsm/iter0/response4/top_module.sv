module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

reg [1:0] state;
reg [1:0] next;

always @(posedge clk) begin
    if (!resetn)
        state <= 2'b00;    // Set state to A
    else
        state <= next;     // Update state based on next state

    case (state)
        2'b00: begin         // State A
            if (r[3])
                next <= 2'b11;  // Next state is D
            else if (r[2])
                next <= 2'b10;  // Next state is C
            else if (r[1])
                next <= 2'b01;  // Next state is B
            else
                next <= 2'b00;  // Next state is A
        end

        2'b01: begin         // State B
            if (r[1])
                next <= 2'b01;  // Next state is B
            else
                next <= 2'b00;  // Next state is A
        end

        2'b10: begin         // State C
            if (r[2])
                next <= 2'b10;  // Next state is C
            else
                next <= 2'b00;  // Next state is A
        end

        2'b11: begin         // State D
            if (r[3])
                next <= 2'b11;  // Next state is D
            else
                next <= 2'b00;  // Next state is A
        end
    endcase
end

assign g[1] = (state == 2'b01);
assign g[2] = (state == 2'b10);
assign g[3] = (state == 2'b11);

endmodule
