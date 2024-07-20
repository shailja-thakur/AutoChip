module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;
    
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            state <= 2'b00;  // initial state A
        end 
        else begin
            case(state)
                2'b00: begin  // state A
                    if(in) begin
                        state <= 2'b01;
                    end 
                    else begin
                        state <= 2'b00;
                    end
                end
                2'b01: begin  // state B
                    if(in) begin
                        state <= 2'b01;
                    end 
                    else begin
                        state <= 2'b10;
                    end
                end
                2'b10: begin  // state C
                    if(in) begin
                        state <= 2'b11;
                    end 
                    else begin
                        state <= 2'b00;
                    end
                end
                2'b11: begin  // state D
                    if(in) begin
                        state <= 2'b01;
                    end 
                    else begin
                        state <= 2'b10;
                    end
                end
            endcase
        end
    end
    
    assign out = (state == 2'b11) ? 1'b1 : 1'b0;
    
endmodule
