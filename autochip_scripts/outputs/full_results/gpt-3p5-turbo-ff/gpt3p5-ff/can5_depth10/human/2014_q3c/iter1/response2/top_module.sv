module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);
    // Declare internal signals
    reg [2:0] Y_next;
    
    // State assignments
    always @(posedge clk) begin
        case(y)
            3'b000: begin
                if (x)
                    Y_next = 3'b001;
                else
                    Y_next = 3'b000;
                end
            3'b001: begin
                if (x)
                    Y_next = 3'b100;
                else
                    Y_next = 3'b001;
                end
            3'b010: begin
                if (x)
                    Y_next = 3'b001;
                else
                    Y_next = 3'b010;
                end
            3'b011: begin
                if (x)
                    Y_next = 3'b010;
                else
                    Y_next = 3'b001;
                end
            3'b100: begin
                if (x)
                    Y_next = 3'b100;
                else
                    Y_next = 3'b011;
                end
            default: Y_next <= 3'b000;
        endcase
    end
    
    // Output assignments
    always @(posedge clk) begin
        if (Y_next == 3'b000)
            Y0 <= 1'b0;
        else
            Y0 <= 1'b1;
        
        if (y == 3'b011)
            z <= 1'b1;
        else
            z <= 1'b0;
    end

endmodule
