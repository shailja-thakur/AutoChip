module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

// Define states
localparam A = 3'd0;
localparam B = 3'd1;
localparam C = 3'd2;
localparam D = 3'd3;

// Declare current state and next state variables
reg [2:0] current_state, next_state;

// Declare signals for r1, r2, r3
wire r1 = r[0];
wire r2 = r[1];
wire r3 = r[2];

// State transition logic
always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        current_state <= A;
    end else begin
        current_state <= next_state;
    end
end

// State transition logic
always @(current_state or r1 or r2 or r3) begin
    case (current_state)
        A: begin
            if (r1 && ~(r2 || r3)) begin
                next_state = A;
            end else if (r1) begin
                next_state = B;
            end else if (r2) begin
                next_state = C;
            end else begin
                next_state = D;
            end
        end
        B: begin
            if (g1) begin
                if (r1) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end else begin
                next_state = B;
            end
        end
        C: begin
            if (g2) begin
                if (r2) begin
                    next_state = C;
                end else begin
                    next_state = A;
                end
            end else begin
                next_state = C;
            end
        end
        default: next_state = A;
    endcase
end

// Output logic
always @(posedge clk) begin
    if (~resetn) begin
        g <= 3'b000;
    end else begin
        case (current_state)
            A: begin
                if (r1 && ~(r2 || r3) && !(g1 || g2 || g3)) begin
                    g <= 3'b001; // assign g1 to 1
                end else if (r1 && ~(r2 || r3) && !(g1 || g2 || g3)) begin
                    g <= 3'b001; // assign g1 to 1
                end else if (r2 && ~(r1 || r3) && !(g1 || g2 || g3)) begin
                    g <= 3'b010; // assign g2 to 1
                end else if (r3 && ~(r1 || r2) && !(g1 || g2 || g3)) begin
                    g <= 3'b100; // assign g3 to 1
                end else begin
                    g <= 3'b000;
                end
            end
            B: begin
                if (r1 && ~(r2 || r3) && g1) begin
                    g <= 3'b001; // assign g1 to 1
                end else if (~r1 && ~(r2 || r3) && ~g1) begin
                    g <= 3'b000;
                end
            end
            C: begin
                if (r2 && ~(r1 || r3) && g2) begin
                    g <= 3'b010; // assign g2 to 1
                end else if (~r2 && ~(r1 || r3) && ~g2) begin
                    g <= 3'b000;
                end
            end
            default: begin
                g <= 3'b000;
            end
        endcase
    end
end

endmodule
