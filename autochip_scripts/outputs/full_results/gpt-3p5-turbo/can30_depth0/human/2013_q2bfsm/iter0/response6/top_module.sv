module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);

reg [1:0] state; // state variable

// state enumeration
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// flip-flop to hold value of f
reg f_ff;
always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        f_ff <= 1'b0;
    end else begin
        f_ff <= f;
    end
end

// flip-flop to hold value of g
reg g_ff;
always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        g_ff <= 1'b0;
    end else begin
        g_ff <= g;
    end
end

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= A;
    end else begin
        case(state)
            A: begin
                if (~resetn) begin
                    state <= A;
                end else if (~resetn && x) begin
                    state <= B;
                end else begin
                    state <= A;
                end
            end
            B: begin
                if (~resetn && ~x) begin
                    state <= C;
                end else begin
                    state <= B;
                end
            end
            C: begin
                if (~resetn && x) begin
                    state <= D;
                end else begin
                    state <= C;
                end
            end
            D: begin
                if (~resetn) begin
                    state <= A;
                end else if (~resetn && y) begin
                    state <= D;
                end else if (~resetn && ~y) begin
                    state <= C;
                end else begin
                    state <= D;
                end
            end
            default: state <= A;
        endcase
    end
end

// output assignments
assign f = (state == B);
assign g = g_ff;

endmodule
