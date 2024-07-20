module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    // Define the state encoding
    parameter S0 = 10'b0000000001;  // 0
    parameter S1 = 10'b0000000010;  // 1
    parameter S2 = 10'b0000000100;  // 2
    parameter S3 = 10'b0000001000;  // 3
    parameter S4 = 10'b0000010000;  // 4
    parameter S5 = 10'b0000100000;  // 5
    parameter S6 = 10'b0001000000;  // 6
    parameter S7 = 10'b0010000000;  // 7
    parameter S8 = 10'b0100000000;  // 8
    parameter S9 = 10'b1000000000;  // 9

    // Define the state flip-flop inputs
    wire [9:0] next_state_ff;
    assign next_state_ff = next_state & state;
      
    always @(posedge in) begin
        case (state)
            S0: begin
                if (in == 1'b0) begin
                    next_state = S0;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end else begin
                    next_state = S1;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
            end
            
            S1: begin
                if (in == 1'b0) begin
                    next_state = S0;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end else begin
                    next_state = S2;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
            end
            
            S2: begin
                if (in == 1'b0) begin
                    next_state = S0;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end else begin
                    next_state = S3;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
            end
            
            S3: begin
                if (in == 1'b0) begin
                    next_state = S0;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end else begin
                    next_state = S4;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
            end
            
            S4: begin
                if (in == 1'b0) begin
                    next_state = S0;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end else begin
                    next_state = S5;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
            end
            
            S5: begin
                if (in == 1'b0) begin
                    next_state = S8;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end else begin
                    next_state = S6;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
            end
            
            S6: begin
                if (in == 1'b0) begin
                    next_state = S9;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end else begin
                    next_state = S7;
                    out1 = 1'b0;
                    out2 = 1'b0;
                end
            end
            
            S7: begin
                if (in == 1'b0) begin
                    next_state = S0;
                    out1 = 1'b0;
                    out2 = 1'b1;
                end else begin
                    next_state = S7;
                    out1 = 1'b0;
                    out2 = 1'b1;
                end
            end
            
            S8: begin
                if (in == 1'b0) begin
                    next_state = S0;
                    out1 = 1'b1;
                    out2 = 1'b0;
                end else begin
                    next_state = S1;
                    out1 = 1'b1;
                    out2 = 1'b0;
                end
            end
            
            S9: begin
                if (in == 1'b0) begin
                    next_state = S0;
                    out1 = 1'b1;
                    out2 = 1'b1;
                end else begin
                    next_state = S1;
                    out1 = 1'b1;
                    out2 = 1'b1;
                end
            end
        endcase
    end
endmodule
