module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

reg [3:1] state, next_state;
reg [3:1] g_output;

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @* begin
    g_output = 3'b000;

    case (state)
        A: begin
            if (r[1] == 1'b1 && r[2] == 1'b1 && r[3] == 1'b1) begin
                next_state = A;
            end else if (r[1] == 1'b1) begin
                next_state = B;
            end else if (r[2] == 1'b1) begin
                next_state = C;
            end else if (r[3] == 1'b1) begin
                next_state = D;
            end
        end

        B: begin
            if (r[1] == 1'b1) begin
                next_state = B;
                g_output[1] = 1'b1;
            end else begin
                next_state = A;
                g_output[1] = 1'b0;
            end
        end

        C: begin
            if (r[2] == 1'b1) begin
                next_state = C;
                g_output[2] = 1'b1;
            end else begin
                next_state = A;
                g_output[2] = 1'b0;
            end
        end

        D: begin
            next_state = A;
        end
    endcase
end

assign g = g_output;

endmodule
