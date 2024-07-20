module top_module (
    input wire clk,
    input wire resetn,
    input wire [2:0] r,
    output wire [2:0] g
);

// Define the states
localparam A = 2'b00;
localparam B = 2'b01;
localparam C = 2'b10;
localparam D = 2'b11;

// Define the inputs
reg [1:0] state;
reg [1:0] next_state;
reg grant1, grant2, grant3;

// State transition and output logic
always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= A;
        grant1 <= 0;
        grant2 <= 0;
        grant3 <= 0;
    end else begin
        state <= next_state;
        grant1 <= (state == B && r[2] && ~r[1] && ~r[0]) ? 1'b1 : 1'b0;
        grant2 <= (state == B && ~r[2] && ~r[1] && ~r[0]) ? 1'b1 : 1'b0;
        grant3 <= (state == C && r[1] && ~r[2] && ~r[0]) ? 1'b1 : 1'b0;
    end
end

// State transition logic
always @(state, r) begin
    case (state)
        A: begin
            if (r[0] && ~r[1] && ~r[2]) begin
                next_state = B;
            end else if (~r[0] && ~r[1] && r[2]) begin
                next_state = C;
            end else if (~r[0] && ~r[1] && ~r[2]) begin
                next_state = D;
            end else begin
                next_state = A;
            end
        end
        B: begin
            if (~r[0]) begin
                next_state = A;
            end else begin
                next_state = B;
            end
        end
        C: begin
            if (~r[1]) begin
                next_state = A;
            end else begin
                next_state = C;
            end
        end
        D: begin
            if (~r[0] && ~r[1] && ~r[2]) begin
                next_state = A;
            end else begin
                next_state = D;
            end
        end
    endcase
end

// Output assignment
assign g[0] = grant1;
assign g[1] = grant2;
assign g[2] = grant3;
    
endmodule
