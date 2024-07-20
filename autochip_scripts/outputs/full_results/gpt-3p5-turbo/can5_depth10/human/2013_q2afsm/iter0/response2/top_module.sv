module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

// State codes
// A: 2'b00
// B: 2'b01
// C: 2'b10
// D: 2'b11

// State flip-flops
reg [1:0] current_state, next_state;

// Outputs
assign g[1] = (current_state == 2'b01) ? 1'b1 : 1'b0;
assign g[2] = (current_state == 2'b10) ? 1'b1 : 1'b0;
assign g[3] = (current_state == 2'b00) ? 1'b1 : 1'b0;

// Next state logic
always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        current_state <= 2'b00; // A
    end
    else begin
        current_state <= next_state;
    end
end

// State table
always @* begin
    case (current_state)
        2'b00: begin // A
            if (r[1] & ~r[2] & ~r[3]) begin
                next_state = 2'b00; // A
            end
            else if (r[1]) begin
                next_state = 2'b01; // B
            end
            else if (~r[1] & r[2]) begin
                next_state = 2'b10; // C
            end
            else begin
                next_state = 2'b11; // D
            end
        end
      
        2'b01: begin // B
            if (r[1] & g[1]) begin
                next_state = 2'b01; // B
            end
            else begin
                next_state = 2'b00; // A
            end
        end

        2'b10: begin // C
            if (r[2] & g[2]) begin
                next_state = 2'b10; // C
            end
            else begin
                next_state = 2'b00; // A
            end
        end

        2'b11: begin // D
            next_state = 2'b00; // A
        end
    endcase
end

endmodule
