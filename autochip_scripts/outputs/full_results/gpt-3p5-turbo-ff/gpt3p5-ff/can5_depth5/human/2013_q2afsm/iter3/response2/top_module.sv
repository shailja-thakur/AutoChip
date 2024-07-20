module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

// Define the states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

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
        grant1 <= 0;
        grant2 <= 0;
        grant3 <= 0;
        case (state)
            A: begin
                if (r[1] && ~r[2] && ~r[3]) begin
                    grant1 <= 1;
                    next_state = A;
                end else if (r[1]) begin
                    grant1 <= 1;
                    next_state = B;
                end else if (~r[1] && r[2]) begin
                    grant2 <= 1;
                    next_state = C;
                end else if (~r[1] && ~r[2] && ~r[3]) begin
                    grant3 <= 1;
                    next_state = D;
                end 
            end
            B: begin
                if (~r[1]) begin
                    grant1 <= 1;
                    next_state = A;
                end else begin
                    grant1 <= 1;
                    next_state = B;
                end
            end
            C: begin
                if (~r[2]) begin
                    grant2 <= 1;
                    next_state = A;
                end else begin
                    grant2 <= 1;
                    next_state = C;
                end
            end
            D: begin
                if (~r[1] && ~r[2] && ~r[3]) begin
                    grant3 <= 1;
                    next_state = A;
                end else begin
                    next_state = D;
                end
            end
            default: next_state = A;
        endcase
    end
end

// Output assignment
always @(posedge clk) begin
    if (resetn == 0) begin
        g <= 0;
    end else begin
        g <= {grant3, grant2, grant1};
    end
end

endmodule
