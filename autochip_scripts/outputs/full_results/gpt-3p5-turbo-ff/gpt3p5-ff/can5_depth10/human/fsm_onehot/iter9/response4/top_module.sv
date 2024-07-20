module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    // Define the logic equations for the states transitions and outputs
    always @*
    begin
        case (state)
            0: begin
                next_state = {1'b1, state[8:1]};
                out1 = 1'b0;
                out2 = 1'b0;
            end
            1: begin
                next_state = in ? {1'b0, 1'b0, state[7:2]} : {1'b0, 1'b0, state[7:2]};
                out1 = 1'b0;
                out2 = 1'b0;
            end
            2: begin
                next_state = in ? {1'b0, 1'b0, state[7:3]} : {1'b0, 1'b0, state[7:3]};
                out1 = 1'b0;
                out2 = 1'b0;
           end
            3: begin
                next_state = in ? {1'b0, 1'b0, state[7:4]} : {1'b0, 1'b0, state[7:4]};
                out1 = 1'b0;
                out2 = 1'b0;
            end
            4: begin
                next_state = in ? {1'b0, 1'b0, state[7:5]} : {1'b0, 1'b0, state[7:5]};
                out1 = 1'b0;
                out2 = 1'b0;
            end
            5: begin
                next_state = in ? {1'b0, state[8:6,4:0]} : {1'b0, state[8:6,4:0]};
                out1 = state[6] || state[9];
                out2 = state[7];
            end
            6: begin
                next_state = in ? {1'b1, state[8:2]} : {1'b1, state[8:2]};
                out1 = 1'b0;
                out2 = 1'b0;
            end
            7: begin
                next_state = in ? {1'b0, 1'b0, state[7:1]} : {1'b0, 1'b0, state[7:1]};
                out1 = 1'b0;
                out2 = 1'b0;
            end
            8: begin
                next_state = in ? {1'b0, state[8:2]} : {1'b0, state[8:2]};
                out1 = 1'b0;
                out2 = 1'b0;
            end
            9: begin
                next_state = in ? {1'b0, state[8:2]} : {1'b0, state[8:2]};
                out1 = 1'b0;
                out2 = 1'b0;
            end
            default: begin
                next_state = state;
                out1 = 1'b0;
                out2 = 1'b0;
                
            end
        endcase
    end
endmodule
