module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

// Define states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Declare current state and next state
reg [1:0] current_state;
reg [1:0] next_state;

// Declare outputs
reg [3:1] g_output;
wire [3:1] g_wire;

// State flip-flop
always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        current_state <= A;
    end else begin
        current_state <= next_state;
    end
end

// State table
always @(current_state, r) begin
    case (current_state)
        A: begin
            if (r[1] && r[2] && r[3]) begin
                next_state = A;
            end else if (r[1]) begin
                next_state = B;
            end else if (r[2]) begin
                next_state = C;
            end else if (r[3]) begin
                next_state = D;
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

// Update outputs
always @(current_state) begin
    case (current_state)
        A: begin
            g_output = 3'b000;
        end
        B: begin
            g_output = 3'b100;
        end
        C: begin
            g_output = 3'b010;
        end
        D: begin
            g_output = 3'b001;
        end
    endcase
end

// Assign outputs
assign g_wire = g_output;
assign g = g_wire;

endmodule
