module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

// Declare the present and next state variables
reg [2:0] present_state;
reg [2:0] next_state;

// Assign the present state
always @(posedge clk)
begin
    present_state <= y;
end

// Assign the next state and output based on the present state and input x
always @(*)
begin
    case (present_state)
        3'b000:
            begin
                if (x == 1'b0)
                begin
                    next_state = 3'b000;
                    z = 1'b0;
                end
                else
                begin
                    next_state = 3'b001;
                    z = 1'b0;
                end
            end
            
        3'b001:
            begin
                if (x == 1'b0)
                begin
                    next_state = 3'b001;
                    z = 1'b0;
                end
                else
                begin
                    next_state = 3'b100;
                    z = 1'b0;
                end
            end
            
        3'b010:
            begin
                if (x == 1'b0)
                begin
                    next_state = 3'b010;
                    z = 1'b0;
                end
                else
                begin
                    next_state = 3'b001;
                    z = 1'b0;
                end
            end
            
        3'b011:
            begin
                if (x == 1'b0)
                begin
                    next_state = 3'b001;
                    z = 1'b0;
                end
                else
                begin
                    next_state = 3'b010;
                    z = 1'b1;
                end
            end
            
        3'b100:
            begin
                if (x == 1'b0)
                begin
                    next_state = 3'b011;
                    z = 1'b1;
                end
                else
                begin
                    next_state = 3'b100;
                    z = 1'b1;
                end
            end
    endcase
end

// Assign the output Y0
always @(posedge clk)
begin
    Y0 <= next_state[0];
end

endmodule
