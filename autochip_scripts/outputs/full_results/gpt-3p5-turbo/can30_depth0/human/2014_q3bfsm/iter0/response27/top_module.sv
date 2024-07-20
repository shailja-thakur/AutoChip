module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] y_reg, y_next; // Present state and next state
reg z_next; // Next output

// Synchronous reset
always @(posedge clk or posedge reset)
begin
    if (reset)
        y_reg <= 3'b0; // State 000
    else
        y_reg <= y_next;
end

// Next state and output logic
always @(y_reg or x)
begin
    case (y_reg)
        3'b000: begin
            if (x)
            begin
                y_next = 3'b001; // Next state 001
                z_next = 1'b0; // Output 0
            end
            else
            begin
                y_next = 3'b000; // Next state 000
                z_next = 1'b0; // Output 0
            end
        end

        3'b001: begin
            if (x)
            begin
                y_next = 3'b100; // Next state 100
                z_next = 1'b0; // Output 0
            end
            else
            begin
                y_next = 3'b001; // Next state 001
                z_next = 1'b0; // Output 0
            end
        end

        3'b010: begin
            if (x)
            begin
                y_next = 3'b001; // Next state 001
                z_next = 1'b0; // Output 0
            end
            else
            begin
                y_next = 3'b010; // Next state 010
                z_next = 1'b0; // Output 0
            end
        end

        3'b011: begin
            if (x)
            begin
                y_next = 3'b010; // Next state 010
                z_next = 1'b1; // Output 1
            end
            else
            begin
                y_next = 3'b001; // Next state 001
                z_next = 1'b0; // Output 0
            end
        end

        3'b100: begin
            if (x)
            begin
                y_next = 3'b100; // Next state 100
                z_next = 1'b1; // Output 1
            end
            else
            begin
                y_next = 3'b011; // Next state 011
                z_next = 1'b1; // Output 1
            end
        end
    endcase
end

// Output assignment
always @(posedge clk)
begin
    z <= z_next;
end

endmodule
