module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);
    
    reg [3:0] state;
    reg [3:0] next_state;
    
    // State encodings
    parameter S0 = 4'b0000;
    parameter S1 = 4'b0001;
    parameter S2 = 4'b0010;
    parameter S3 = 4'b0011;
    parameter S4 = 4'b0100;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end
    
    always @(state or data) begin
        case (state)
            S0: begin
                if (data)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1: begin
                if (data)
                    next_state = S2;
                else
                    next_state = S0;
            end
            S2: begin
                if (data)
                    next_state = S3;
                else
                    next_state = S0;
            end
            S3: begin
                if (data)
                    next_state = S4;
                else
                    next_state = S0;
            end
            S4: begin
                if (data)
                    begin
                        next_state = S1;
                        start_shifting = 1;
                    end
                else
                    next_state = S0;
            end
        endcase
    end
endmodule
