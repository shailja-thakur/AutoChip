module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

    reg [1:0] state;
    wire [1:0] next_state;
    
    assign start_shifting = (state == 2'b11);
    
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            state <= 2'b00;
        else
            state <= next_state;
    end
    
    always @(*)
    begin
        case(state)
            2'b00: begin
                if (data)
                    next_state = 2'b01;
                else
                    next_state = 2'b00;
            end
            2'b01: begin
                if (data)
                    next_state = 2'b11;
                else
                    next_state = 2'b00;
            end
            2'b11: begin
                if (data)
                    next_state = 2'b11;
                else
                    next_state = 2'b10;
            end
            2'b10: begin
                if (data)
                    next_state = 2'b11;
                else
                    next_state = 2'b11;
            end
            default: next_state = 2'b00;
        endcase
    end
    
endmodule
