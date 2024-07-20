module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output [2:0] g
);

// State encoding
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;

// Define state register
reg [2:0] current_state, next_state;
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        current_state <= A;
    end else begin
        current_state <= next_state;
    end
end

// Define next state logic
always @(current_state or r) begin
    case (current_state)
        A: begin
            if (r[1] & !r[2] & !r[3]) begin
                next_state = A;
            end else if (!r[1] & !r[2] & !r[3]) begin
                next_state = D;
            end else if (!r[1]) begin
                next_state = B;
            end else if (!r[2]) begin
                next_state = C;
            end
        end
        B: begin
            if (r[1]) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
        C: begin
            if (r[2]) begin
                next_state = C;
            end else begin
                next_state = A;
            end
        end
        D: begin
            next_state = A;
        end
    endcase
end

// Define g outputs
assign g[1] = (current_state == B);
assign g[2] = (current_state == C);
assign g[3] = (current_state == D);

endmodule
