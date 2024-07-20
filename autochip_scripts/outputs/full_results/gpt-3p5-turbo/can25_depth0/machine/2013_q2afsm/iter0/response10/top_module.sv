module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);
    
reg [1:0] state;
reg [1:0] next;

always @(posedge clk) begin
    if (!resetn)
        state <= 2'b00; // Set state to A
    else
        state <= next; // Update state to next state
end

always @* begin
    case (state)
        2'b00: begin // State A
            if (r[1]) begin
                next = 2'b01; // Next state is B
            end else if (r[2]) begin
                next = 2'b10; // Next state is C
            end else if (r[3]) begin
                next = 2'b11; // Next state is D
            end else begin
                next = 2'b00; // Next state is A
            end
        end
        2'b01: begin // State B
            if (r[1]) begin
                next = 2'b01; // Next state is B
            end else begin
                next = 2'b00; // Next state is A
            end
        end
        2'b10: begin // State C
            if (r[2]) begin
                next = 2'b10; // Next state is C
            end else begin
                next = 2'b00; // Next state is A
            end
        end
        2'b11: begin // State D
            if (r[3]) begin
                next = 2'b11; // Next state is D
            end else begin
                next = 2'b00; // Next state is A
            end
        end
    endcase
end

assign g = (state == 2'b01) ? 3'b001 :
           (state == 2'b10) ? 3'b010 :
           (state == 2'b11) ? 3'b100 :
           3'b000;

endmodule
