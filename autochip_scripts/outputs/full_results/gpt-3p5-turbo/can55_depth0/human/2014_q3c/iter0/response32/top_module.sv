module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

// Declare the next state reg for Y[2:0]
reg [2:0] Y_next;

// State-assigned table using case statement
always @(*) begin
    case(y)
        3'b000: begin
            if(x == 1) begin
                Y_next = 3'b001;
                z = 1'b0;
            end
            else begin
                Y_next = 3'b000;
                z = 1'b0;
            end
        end
        
        3'b001: begin
            if(x == 1) begin
                Y_next = 3'b100;
                z = 1'b0;
            end
            else begin
                Y_next = 3'b001;
                z = 1'b0;
            end
        end
        
        3'b010: begin
            if(x == 1) begin
                Y_next = 3'b001;
                z = 1'b0;
            end
            else begin
                Y_next = 3'b010;
                z = 1'b0;
            end
        end
        
        3'b011: begin
            if(x == 1) begin
                Y_next = 3'b010;
                z = 1'b1;
            end
            else begin
                Y_next = 3'b001;
                z = 1'b0;
            end
        end
        
        3'b100: begin
            if(x == 1) begin
                Y_next = 3'b100;
                z = 1'b1;
            end
            else begin
                Y_next = 3'b011;
                z = 1'b1;
            end
        end
    endcase
end

// Assign the next state reg to the output reg Y[2:0]
always @(posedge clk) begin
    Y0 <= Y_next[0];
    // Assign other bits of Y based on the table mapping
    // ...
end

endmodule
