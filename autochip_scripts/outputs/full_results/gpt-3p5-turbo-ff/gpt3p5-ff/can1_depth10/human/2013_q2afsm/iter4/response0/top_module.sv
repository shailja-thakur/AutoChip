module top_module (
    input  wire        clk,
    input  wire        resetn,
    input  wire [3:1]  r,
    output wire [3:1]  g
);

reg   [3:1] state, next_state;
reg   [3:1] g_output;

parameter A = 3'b00;
parameter B = 3'b01;
parameter C = 3'b10;
parameter D = 3'b11;

always @(posedge clk or negedge resetn) begin
    if (!resetn)
        state <= A;
    else
        state <= next_state;
end

always @(state, r) begin
    next_state = A;
    case (state)
        A: begin
            if (r[1] == 1'b1 && r[2:1] == 2'b00)
                next_state = B;
            else if (r[1] == 1'b0 && r[2] == 1'b1 && r[3] == 1'b0)
                next_state = C;
            else if (r[1:2] == 2'b00 && r[3] == 1'b0)
                next_state = D;
        end
        B: begin
            if (r == 3'b0001)
                next_state = B;
            else if (r == 3'b0000 || r == 3'b0010 || r == 3'b0011)
                next_state = A;
        end
        C: begin
            if (r == 3'b0010)
                next_state = C;
            else if (r == 3'b0000 || r == 3'b0001 || r == 3'b0011)
                next_state = A;
        end
        D: begin
            if (r == 3'b0000)
                next_state = D;
            else
                next_state = A;
        end
    endcase
end

always @(state) begin
    case (state)
        A: g_output = 3'b000;
        B: g_output = 3'b100;
        C: g_output = 3'b010;
        D: g_output = 3'b001;
    endcase
end

assign g = g_output;

endmodule
