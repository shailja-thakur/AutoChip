module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output wire state
);

    reg ff;

    // Assign flip-flop state to output 'state'
    assign state = ff;

    always @(posedge clk) begin
        if (a) begin
            if (b) begin
                ff <= 1;
            end 
            else begin
                ff <= 0;
            end
        end
        else if (b) begin
            ff <= 1;
        end
        else begin
            ff <= 0;
        end
        
        // q should follow the state of the flip-flop
        q <= ff;
    end
endmodule
