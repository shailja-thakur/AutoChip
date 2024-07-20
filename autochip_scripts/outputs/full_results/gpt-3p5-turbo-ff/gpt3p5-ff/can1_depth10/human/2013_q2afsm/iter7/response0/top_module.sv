module top_module (
    input  wire        clk,
    input  wire        resetn,
    input  wire [3:1]  r,
    output wire [3:1]  g
);

reg   [3:1] state, next_state;
wire  [2:0] r_priority;
reg   [3:1] g_output;

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;

assign r_priority = {r[2], r[1], r[3]};

always @(posedge clk or negedge resetn) begin
    if (!resetn)
        state <= A;
    else
        state <= next_state;
end

always @(state, r_priority) begin
    next_state = A;
    case (state)
        A: begin
            if (r_priority == 3'b000)
                next_state <= A;
            else if (r_priority == 3'b001)
                next_state <= B;
            else if (r_priority == 3'b010)
                next_state <= C;
            else if (r_priority == 3'b100)
                next_state <= D;
        end
        B: begin
            if (r_priority == 3'b001)
                next_state <= B;
            else if (r_priority == 3'b000)
                next_state <= A;
            else
                next_state <= A;
        end
        C: begin
            if (r_priority == 3'b010)
                next_state <= C;
            else if (r_priority == 3'b000)
                next_state <= A;
            else
                next_state <= A;
        end
        D: begin
            if (r_priority == 3'b000)
                next_state <= D;
            else
                next_state <= A;
        end
    endcase
end

always @(state) begin
    case (state)
        A: g_output <= 3'b000;
        B: g_output <= 3'b100;
        C: g_output <= 3'b010;
        D: g_output <= 3'b001;
    endcase
end

assign g = g_output;

endmodule
