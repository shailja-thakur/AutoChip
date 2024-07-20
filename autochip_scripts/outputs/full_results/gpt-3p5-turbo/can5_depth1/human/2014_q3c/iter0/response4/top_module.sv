module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

// Instantiate flip flops for storing the current state
reg [2:0] current_state;
always @(posedge clk) begin
    if (x) begin
        case (current_state)
            3'b000: current_state <= 3'b001;
            3'b001: current_state <= 3'b100;
            3'b010: current_state <= 3'b001;
            3'b011: current_state <= 3'b010;
            3'b100: current_state <= 3'b100;
        endcase
    end else begin
        case (current_state)
            3'b000: current_state <= 3'b000;
            3'b001: current_state <= 3'b001;
            3'b010: current_state <= 3'b010;
            3'b011: current_state <= 3'b001;
            3'b100: current_state <= 3'b011;
        endcase
    end
end

// Assign values to the output signals Y0 and z based on the current state
always @(current_state) begin
    case (current_state)
        3'b000: begin
            Y0 = 1'b0;
            z = 1'b0;
        end
        3'b001: begin
            Y0 = 1'b0;
            z = 1'b0;
        end
        3'b010: begin
            Y0 = 1'b0;
            z = 1'b0;
        end
        3'b011: begin
            Y0 = 1'b0;
            z = 1'b1;
        end
        3'b100: begin
            Y0 = 1'b1;
            z = 1'b1;
        end
    endcase
end

endmodule
