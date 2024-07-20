module top_module(
    input [3:1] y,
    input w,
    output reg Y2);

    // Register y2 to store the next state value
    reg [2:0] y2;

    always @(*)
    begin
        case(y)
            3'b000: 
                begin
                    if(w == 0)
                        y2 = 3'b101;
                    else if(w == 1)
                        y2 = 3'b001;
                end
            
            3'b001: 
                begin
                    if(w == 0)
                        y2 = 3'b010;
                    else if(w == 1)
                        y2 = 3'b110;
                end
            
            3'b010: 
                begin
                    if(w == 0)
                        y2 = 3'b100;
                    else if(w == 1)
                        y2 = 3'b011;
                end
            
            3'b011: 
                begin
                    if(w == 0)
                        y2 = 3'b110;
                    else if(w == 1)
                        y2 = 3'b001;
                end
            
            3'b100: 
                begin
                    if(w == 0)
                        y2 = 3'b110;
                    else if(w == 1)
                        y2 = 3'b001;
                end
            
            3'b101:
                begin
                    if(w == 0)
                        y2 = 3'b011;
                    else if(w == 1)
                        y2 = 3'b110;
                end
        endcase
    end

    // Assign y2 to Y2 output
    assign Y2 = y2[2];

endmodule
