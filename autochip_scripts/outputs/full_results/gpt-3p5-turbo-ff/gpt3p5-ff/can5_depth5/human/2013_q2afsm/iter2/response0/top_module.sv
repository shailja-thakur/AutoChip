module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

// Define the states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Define the inputs
reg [1:0] state;
reg [1:0] next_state;
reg [3:1] grant;

// State transition and output logic
always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= A;
        grant <= 0;
    end else begin
        state <= next_state;
        grant[1] <= (state == B && r[1]) ? 1'b1 : 1'b0;
        grant[2] <= (state == C && r[2]) ? 1'b1 : 1'b0;
        grant[3] <= (state == D && r[3]) ? 1'b1 : 1'b0;
    end
end

// State transition logic
always @(state, r) begin
    case (state)
        A: begin
            if (r[1] && ~r[2] && ~r[3]) begin
                next_state = A;
            end else if (r[1]) begin
                next_state = B;
            end else if (~r[1] && r[2]) begin
                next_state = C;
            end else if (~r[1] && ~r[2] && ~r[3]) begin
                next_state = D;
            end 
        end
        B: begin
            if (r[1] && grant[1]) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
        C: begin
            if (r[2] && grant[2]) begin
                next_state = C;
            end else begin
                next_state = A;
            end
        end
        D: begin
            next_state = A;
        end
        default: next_state = A;
    endcase
end

// Output assignment
assign g = grant;

endmodule
