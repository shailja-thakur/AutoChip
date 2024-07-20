module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

    // Define states
    parameter S = 2'b00;
    parameter S1 = 2'b01;
    parameter S11 = 2'b10;
    parameter S110 = 2'b11;
    parameter Done = 2'b100;
    
    // Register to store current state
    reg [2:0] state;
    
    // Assign initial state
    always @(posedge reset)
    begin
        state <= S;
    end
    
    // Combinational logic to determine next state
    always @(posedge clk)
    begin
        case(state)
            S: begin
                if (data)
                    state <= S1;
                else
                    state <= S;
            end
            S1: begin
                if (data)
                    state <= S11;
                else
                    state <= S;
            end
            S11: begin
                if (data)
                    state <= S11;
                else
                    state <= S110;
            end
            S110: begin
                if (data)
                    state <= Done;
                else
                    state <= S;
            end
            Done: begin
                state <= Done;
            end
        endcase
    end
    
    // Assign output based on current state
    always @(state)
    begin
        if (state == Done)
            start_shifting <= 1'b1;
        else
            start_shifting <= 1'b0;
    end
    
endmodule
