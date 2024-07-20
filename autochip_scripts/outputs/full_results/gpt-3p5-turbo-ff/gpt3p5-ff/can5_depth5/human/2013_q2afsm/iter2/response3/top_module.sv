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
wire [1:0] grant_next;
wire [1:0] grant;
reg [1:0] g_reg;
reg [1:0] g_next;

// State transition and output logic
always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @(state, r) begin
    case(state)
        A: begin
            if(r[1] && ~r[2] && ~r[3]) begin
                next_state = A;
            end else if(r[1] && !grant_next[1]) begin
                next_state = B;
            end else if(~r[1] && r[2] && !grant_next[2]) begin
                next_state = C;
            end else if(~r[1] && ~r[2] && ~r[3]) begin
                next_state = D;
            end else begin
                next_state = A;
            end
        end
        B: begin
            if(grant_next[1]) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
        C: begin
            if(grant_next[2]) begin
                next_state = C;
            end else begin
                next_state = A;
            end
        end
        D: begin
            if(~r[1] && ~r[2] && ~r[3]) begin
                next_state = A;
            end else begin
                next_state = D;
            end
        end
        default: next_state = A;
    endcase
end

always @(posedge clk or negedge resetn) begin
    if(~resetn) begin
        grant[1] <= 0;
        grant[2] <= 0;
        g_reg <= 0;
    end else begin
        grant <= grant_next;
        g_reg <= g_next;
    end
end

always @(state, r) begin
    g_next[1] = (state == B) ? r[1] : 0;
    g_next[2] = (state == C) ? r[2] : 0;
    g_next[3] = (state == D) ? r[3] : 0;
end

// Output assignment
assign g = g_reg;

// Grant assignment
assign grant_next[1] = (state == B && r[1]);
assign grant_next[2] = (state == C && r[2]);
assign grant_next[3] = 0;

endmodule
